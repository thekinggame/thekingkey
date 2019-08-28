import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/index/index'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/game',
      name: 'game',
      component: () => import(/* webpackChunkName: "about" */ '@/views/game/game.vue')
    }
  ]
})