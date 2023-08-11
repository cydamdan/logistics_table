# 移动端开发

### 技术选型：vue3+vite+NutUI

### 一、页面

![image-20230722142233229](C:\Users\Administrator\Desktop\记录\img\image-20230722142233229-1690006959830-1.png)

###### 功能说明：

1. 可以选择起始日期与截止日期，并按照日期范围筛选数据
2. 可以查看表格数据

-----

###### 功能实现（以总表为例）：

```vue
<template>
  <!-- 选择日期 -->
  <!-- 使用NutUI的DatePicker -->
  <div class="DatePicker">
    <!-- 左边 -->
    <div class="date-cell">
      <!-- <h6>起始：</h6> -->
      <nut-cell
        title="起始时间:"
        :desc="popupStart"
        @click="showStart = true"
      ></nut-cell>
      <nut-popup position="bottom" v-model:visible="showStart">
        <nut-date-picker
          v-model="currentDate"
          :min-date="minDate"
          :max-date="maxDate"
          @confirm="popupConfirm"
          :is-show-chinese="true"
          :threeDimensional="false"
        >
        </nut-date-picker>
      </nut-popup>
    </div>

    <!-- 右边 -->
    <div class="date-cell">
      <!-- <h6>截止：</h6> -->
      <!-- 使用NutUI的DatePicker -->
      <nut-cell
        title="截止时间:"
        :desc="popupEnd"
        @click="showEnd = true"
      ></nut-cell>
      <nut-popup position="bottom" v-model:visible="showEnd">
        <nut-date-picker
          v-model="currentDateEnd"
          :min-date="minDate"
          :max-date="maxDate"
          @confirm="popupConfirmEnd"
          :is-show-chinese="true"
          :threeDimensional="false"
        >
        </nut-date-picker>
      </nut-popup>
    </div>
  </div>
  <div class="btn">
    <nut-button
      title="Toast"
      shape="square"
      plain
      type="primary"
      @click="searchDate"
      >搜索</nut-button
    >
  </div>

  <!-- 分割线 -->
  <nut-divider />

  <!-- 表格 -->
  <div class="table">
    <nut-table :columns="columns3" :data="data2" :striped="striped"></nut-table>
  </div>
</template>

<script>
import { ref, reactive, toRefs, onMounted } from "vue";
import { showToast } from "@nutui/nutui";
import axios from "axios";
export default {
  props: {},
  setup(props) {
    // 选择日期
    const msg = "请选择日期";
    const showStart = ref(false);	//起始日期是否展示用户选择日期
    const showEnd = ref(false);	//截止日期是否展示用户选择日期
    const popupStart = ref();	//起始日期用户选择日期数据
    const popupEnd = ref();	//截止日期用户选择日期数据
    const minDate = new Date(2020, 0, 1);	//日期选择器最小值
    const maxDate = new Date(2025, 10, 1);	//日期选择器最大值
    const currentDate = new Date(2022, 4, 23);	//日期选择器默认起始日期选择的日期值
    const currentDateEnd = new Date(2023, 8, 15);	//日期选择器默认截止日期选择的日期值
      //起始时间用户确认选择
    const popupConfirm = ({ selectedValue, selectedOptions }) => {
      popupStart.value = selectedOptions.map((val) => val.text).join("");
      showStart.value = false;
    };
      //截止时间用户确认选择
    const popupConfirmEnd = ({ selectedValue, selectedOptions }) => {
      popupEnd.value = selectedOptions.map((val) => val.text).join("");
      showEnd.value = false;
    };
    // 转换日期选择器的日期格式
    const formatDateToYYYYMMDD = (dateString) => {
      const year = dateString.substring(0, 4);
      const month = dateString.substring(5, 7);
      const day = dateString.substring(8, 10);
      if (!year || !month || !day) {
        console.error("日期字符串没有适合的格式:", dateString);
        return null;
      }
      return `${year}-${month}-${day}`;
    };
    // 搜索日期范围内数据
      //async/await 是一种更加优雅的异步编程的写法,用同步的写法写异步的代码
        const searchDate = async () => {
            //如果两个日期选择器用户都选择了日期
      if (popupStart.value && popupEnd.value) {
        try {
          const startDate = formatDateToYYYYMMDD(popupStart.value);
          const endDate = formatDateToYYYYMMDD(popupEnd.value);
            //将格式化后的数据通过参数传给后端
          const response = await axios.get(
            `http://localhost:3000/total?startDate=${startDate}&endDate=${endDate}`
          );
          state.data2 = response.data;
        } catch (error) {
          console.error("获取过滤数据时出错:", error);
        }
      } else {	//其他情况则显示警告提示
        showToast.warn(msg);
      }
    };

    // 表格
    const state = reactive({
      striped: true,
      columns3: [
        {
          title: "时间",
          key: "time",
        },
        {
          title: "项目",
          key: "object",
        },
        {
          title: "人次",
          key: "number",
        },
        {
          title: "总数",
          key: "sum",
        },
      ],
      data2: [],
    });
    // 在组件挂载后获取数据
    onMounted(async () => {
      try {
        const response = await axios.get("http://localhost:3000/total"); // 使用server.js的地址
        state.data2 = response.data; // 服务器返回的数据直接是表格所需的数组
      } catch (error) {
        console.error("获取数据错误:", error);
        // 根据需要，可以在此添加错误处理，例如显示消息给用户
      }
    });
    return {
      showStart,
      showEnd,
      popupStart,
      popupEnd,
      popupConfirmEnd,
      popupConfirm,
      searchDate,
      minDate,
      maxDate,
      currentDate,
      currentDateEnd,
      ...toRefs(state),
    };
  },
};
</script>

<style scoped>
h4 {
  text-align: center;
}
.DatePicker {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.date-cell {
  display: flex;
}

.btn {
  display: flex;
  justify-content: center; /* 按钮水平居中对齐 */
  margin-top: 10px; /* 添加适当的上边距，使按钮与日期选择器之间有间距 */
}
</style>

```

