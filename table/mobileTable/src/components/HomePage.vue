<template>
  <div>
    <nut-navbar @on-click-back="back">
    <template #content>
      <nut-tabs v-model="tab2value" @click="changeTabList">
        <nut-tab-pane title="总表"></nut-tab-pane>
        <nut-tab-pane title="充值表" ></nut-tab-pane>
        <nut-tab-pane title="明细表"> </nut-tab-pane>
        <nut-tab-pane title="营业表"> </nut-tab-pane>
        <nut-tab-pane title="分餐表"> </nut-tab-pane>
      </nut-tabs>
    </template>
    </nut-navbar>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { onMounted } from 'vue';
export default{
  setup(){
    const tab2value = ref(0);
    const router = useRouter();
    // 设置页面默认路由，刷新页面后默认为'/total'
    onMounted(() => {
      router.push('/total')
    });
    const methods = {
      back(){
        console.log('Click Back');
      },
      changeTabList(tab){
        // 编程式导航路由
        if(tab.paneKey === '0'){
          router.push('/total')
        }else if(tab.paneKey === '1'){
          router.push('/recharge')
        }else if(tab.paneKey === '2'){
          router.push('/details')
        }else if(tab.paneKey === '3'){
          router.push('/businessTotal')
        }else if(tab.paneKey === '4'){
          router.push('/division')
        }
        tab2value.value = tab.paneKey;
      },
    }
    return {
    tab2value,
    ...methods
  };
  }

}
</script>

<style scoped>
h3{
  text-align: center;
}
ul {
    list-style: none;
    display: flex;
    flex-direction: row; /* 横向排列 */
    align-items: center; /* 垂直居中对齐 */
  }

  li {
    margin-right: 10px; /* 调整链接之间的间距 */
  }

  /* 去除链接的默认样式 */
  a {
    text-decoration: none;
    color: inherit;
    font-weight: 400;
  }

</style>