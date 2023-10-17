 #include <iostream>
 #include <stdio.h> 
 #include <memory> 
 #include <string> 
 #include <cstring> 
 #include <vector>
 #include <unordered_map>
 
 std::vector<int> twoSum(std::vector<int>& nums, int target) {
     std::unordered_map<int, int> numToIndex;
     for (int i = 0; i < nums.size(); i++) {    
     int complement = target - nums[i];
      if (numToIndex.find(complement) != numToIndex.end()) {
          return {numToIndex[complement], i}; 
      }   
      numToIndex[nums[i]] = i;
      }   
 }