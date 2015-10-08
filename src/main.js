import Vue from 'vue';
global.Vue = Vue;

import animate from 'gsap-promise';
global.animate = animate;


const App = Vue.extend({
  template: `<component is="home"></component>`,
  components: {
    home: require('./home/home.js')
  }
});

const app = new App({el: 'body', replace: false});
