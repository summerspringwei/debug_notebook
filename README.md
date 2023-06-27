## Debug opt passes

### Reproduce the bug
LLVM version: `llvmorg-16.0.6`

Run the following command:
```shell
bash build.sh
```
We can see an error message:

`opt: invalid use of 'loop' pass as module pipeline`.

### Search for the error message:
Run
```shell
cd path/to/llvm
grep -rn "pass as module pipeline"
```
We can find that `llvm/lib/Passes/PassBuilder.cpp:1168` produces the message.

### Debug

Using gdb to find which line of code produces the error:
Note we need first generate the `foo.bc`.
Run 
```shell
gdb opt
gdb > b llvm/lib/Passes/PassBuilder.cpp:1168
gdb > r -passes='wholeprogramdevirt,loop(no-op-loopnest)' foo.bc -o foo.optbc
```
We can verify that program indeed reaches at this point.
Note that the PassBuilder recursively parse the `passes` argument.
All the parse results are stored in the `PipelineElement`, which is defined at `PassBuilder.h:111`.

For our example, for the first time the `Name` is `wholeprogramdevirt`,
and for the second time `Name` is `loop`.
Function call stack:
```log
#0  llvm::PassBuilder::parseModulePass(llvm::PassManager<llvm::Module, llvm::AnalysisManager<llvm::Module>>&, llvm::PassBuilder::PipelineElement const&) (this=0x7fffffffce10, MPM=..., E=...) at /home/xiachunwei/Software/llvm-project/llvm/lib/Passes/PassBuilder.cpp:1121
#1  0x000055555b5594fb in llvm::PassBuilder::parseModulePassPipeline(llvm::PassManager<llvm::Module, llvm::AnalysisManager<llvm::Module>>&, llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) (this=0x7fffffffce10, MPM=..., Pipeline=...)
    at /home/xiachunwei/Software/llvm-project/llvm/lib/Passes/PassBuilder.cpp:1674
#2  0x000055555b559f9d in llvm::PassBuilder::parsePassPipeline(llvm::PassManager<llvm::Module, llvm::AnalysisManager<llvm::Module>>&, llvm::StringRef) (this=0x7fffffffce10, MPM=..., PipelineText=...) at /home/xiachunwei/Software/llvm-project/llvm/lib/Passes/PassBuilder.cpp:1725
#3  0x000055555763211c in llvm::runPassPipeline (Arg0=..., M=..., TM=0x555562beff50, TLII=0x7fffffffdaa0, Out=0x555562bf2900, 
    ThinLTOLinkOut=0x0, OptRemarkFile=0x0, PassPipeline=..., PassPlugins=..., OK=llvm::opt_tool::OK_OutputBitcode, 
    VK=llvm::opt_tool::VK_VerifyOut, ShouldPreserveAssemblyUseListOrder=false, ShouldPreserveBitcodeUseListOrder=true, 
    EmitSummaryIndex=false, EmitModuleHash=false, EnableDebugify=false, VerifyDIPreserve=false)
    at /home/xiachunwei/Software/llvm-project/llvm/tools/opt/NewPMDriver.cpp:455
#4  0x00005555576615db in main (argc=5, argv=0x7fffffffdf68) at /home/xiachunwei/Software/llvm-project/llvm/tools/opt/opt.cpp:719
```

### Why the error occurs?

Read the code from `PassBuilder.cpp:1125` to `PassBuilder.cpp:1172`,
we can find **that only `module`, `coro-cond`, `cgscc`, `function` are valid `PassPipeline`.**
So we can not directly use `loop` in the `passes` list.
The right way is to wrap loop with a `function` `PassPipeline`.


### The right way

Just replace `loop(no-op-loopnest)` with `function(loop(no-op-loopnest))`.