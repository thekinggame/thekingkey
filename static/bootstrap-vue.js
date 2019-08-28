import Vue from 'vue'

import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap/dist/js/bootstrap.min.js'
import { BAlert } from 'bootstrap-vue'
// import Message from '../components/message/message'

Vue.component('b-alert', BAlert)
Vue.use(BootstrapVue)
