import { createApp } from "vue";
import { createRouter,createWebHistory } from "vue-router";
import App from "./App.vue";
import { IconFont } from '@nutui/icons-vue';
import '@nutui/icons-vue/dist/style_iconfont.css';
import NutUI from "@nutui/nutui";
import "@nutui/nutui/dist/style.css";

// 导入六个可跳转页面的组件
import Home from './components/HomePage.vue';
import TotalTable from './components/TotalTable.vue';
import RechargeTable from './components/RechargeTable.vue';
import Details from './components/Details.vue';
import Division from './components/Division.vue';
import BusinessTotal from './components/BusinessTotal.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/total', component: TotalTable },
  { path: '/recharge', component: RechargeTable },
  { path: '/details', component: Details },
  { path: '/division', component: Division },
  { path: '/businessTotal', component: BusinessTotal }
];
const router = createRouter({
    history: createWebHistory(),
    routes
  });
//   // 设置beforeEach导航守卫
// router.beforeEach((to, from, next) => {
//   if (to.matched.length === 0) {
//     // 如果to.matched为空，表示找不到匹配的路由，即刷新页面时路由为空
//     next({ path: '/total' }); // 将路由重定向到默认路由'/'，即设置的首页
//   } else {
//     next(); // 继续正常跳转
//   }
// });
  
createApp(App).use(NutUI).use(IconFont).use(router).mount("#app");