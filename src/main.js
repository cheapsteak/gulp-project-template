import Vue from 'vue';
global.Vue = Vue;

import animate from 'gsap-promise';
global.animate = animate;


const App = Vue.extend({
  template: `<component is="infinite-scroll"></component>`,
  components: {
    // home: require('./home/home.js'),
    'infinite-scroll': require('./infinite-scroll/infinite-scroll.js')
  }
});

new App({el: 'body', replace: false});
