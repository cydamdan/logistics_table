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
    const showStart = ref(false);
    const showEnd = ref(false);
    const popupStart = ref();
    const popupEnd = ref();
    const minDate = new Date(2020, 0, 1);
    const maxDate = new Date(2025, 10, 1);
    const currentDate = new Date(2022, 4, 10);
    const currentDateEnd = new Date(2023, 7, 10);
    const popupConfirm = ({ selectedValue, selectedOptions }) => {
      popupStart.value = selectedOptions.map((val) => val.text).join("");
      showStart.value = false;
    };
    const popupConfirmEnd = ({ selectedValue, selectedOptions }) => {
      popupEnd.value = selectedOptions.map((val) => val.text).join("");
      showEnd.value = false;
    };
    // 转换日期选择器的日期格式
    const formatDateToYYYYMMDD = (dateString) => {
      if (!dateString) {
        console.error("无效日期字符串:", dateString);
        return null; // 或返回一个默认日期
      }

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
    const searchDate = async () => {
      if (popupStart.value && popupEnd.value) {
        try {
          const startDate = formatDateToYYYYMMDD(popupStart.value);
          const endDate = formatDateToYYYYMMDD(popupEnd.value);
          const response = await axios.get(
            `http://localhost:3000/division?startDate=${startDate}&endDate=${endDate}`
          );
          state.data2 = response.data;
        } catch (error) {
          console.error("获取过滤数据时出错:", error);
        }
      }else{
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
          title: "档口",
          key: "name",
        },
        {
          title: "设备号",
          key: "used_device",
        },
        {
          title: "早餐",
          key: "breakfast",
        },
        {
          title: "午餐",
          key: "lunch",
        },
        {
          title: "晚餐",
          key: "dinner",
        },
        {
          title: "消费金额",
          key: "sum_money",
        },
      ],
      data2: [],
    });
    // 在组件挂载后获取数据
    onMounted(async () => {
      try {
        const response = await axios.get("http://localhost:3000/division"); // 使用server.js的地址
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
