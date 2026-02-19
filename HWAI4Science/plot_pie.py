import matplotlib.pyplot as plt
import numpy as np

# 数据来自FLOPs报告
# Encoding phase: setup + fnn->interp + Kernel1
encoding_time = 0.5626 + 0.3508 + 0.3711  # 1.2845 秒

# Regression phase: nn->compute  
regression_time = 0.3916  # 秒

# Derivation phase: dEdP + V + F2 + Kernel4 + forces
derivation_time = 0.1467 + 0.3360 + 0.0794 + 0.5071 + 0.1826  # 1.2518 秒

# 总时间
total_time = encoding_time + regression_time + derivation_time

# 计算百分比
encoding_percent = (encoding_time / total_time) * 100
regression_percent = (regression_time / total_time) * 100
derivation_percent = (derivation_time / total_time) * 100

# 创建饼图数据
labels = ['Encoding', 'Regression', 'Derivation']
sizes = [encoding_time, regression_time, derivation_time]
colors = ['#ff9999', '#66b3ff', '#99ff99']
explode = (0.05, 0.05, 0.05)  # 分离每个扇形

# 创建饼图
fig, ax = plt.subplots(figsize=(10, 8))

# 绘制饼图
wedges, texts, autotexts = ax.pie(sizes, explode=explode, labels=labels, colors=colors,
                                  autopct='%1.1f%%', shadow=True, startangle=90,
                                  textprops={'fontsize': 14, 'fontweight': 'bold'})

# 设置标题
plt.title('Phase Time Distribution in TensorMD\n', fontsize=18, fontweight='bold')

# 设置百分比标签字体
for autotext in autotexts:
    autotext.set_fontsize(14)
    autotext.set_fontweight('bold')

# 设置标签字体
for text in texts:
    text.set_fontsize(14)
    text.set_fontweight('bold')

# 确保饼图是圆形
ax.axis('equal')

# 调整布局
plt.tight_layout()

# 显示图表
plt.show()
plt.savefig("phase_time_distribution.png")
# 打印统计信息
print(f"Phase Time Distribution:")
print(f"Encoding Phase:  {encoding_time:.4f}s ({encoding_percent:.1f}%)")
print(f"Regression Phase: {regression_time:.4f}s ({regression_percent:.1f}%)")
print(f"Derivation Phase: {derivation_time:.4f}s ({derivation_percent:.1f}%)")
print(f"Total Time: {total_time:.4f}s")
