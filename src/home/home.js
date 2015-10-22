import Vue from 'vue';

Vue.partial('icon-create', require('../../assets/svgs/create.svg')); 
Vue.partial('icon-drafts', require('../../assets/svgs/drafts.svg')); 
Vue.partial('icon-flag', require('../../assets/svgs/flag.svg')); 
Vue.partial('icon-gps_fixed', require('../../assets/svgs/gps_fixed.svg')); 

const sections = [
  { id: 'create', svg: 'icon-create' },
  { id: 'draft', svg: 'icon-drafts' },
  { id: 'flag', svg: 'icon-flag' },
  // { id: 'flag', svg: 'icon-flag' },
];

export default Vue.extend({
  template: require('./home-template.js'),
  data () {
    return {
      textIndex: 0,
      texts: ['my text might change', 'notice how width adjusts automatically to text content', 'potato'],
      showButton: true,
      topMenuSections: sections,
      selectedSection: sections[0]
    };
  },
  methods: {
    incrementTextIndex () {
      this.textIndex++;
    },
    onClick () {
      alert('click!');
    }
  },
  components: {
    'sample-button': require('sample-components/button/button.vue'),
    'extended-button': require('../ui/extended-button/extended-button.js'),
    'top-menu': require('sample-components/top-menu/top-menu.vue')
  },
  transitions: {
    animateInOut: {
      enter (el, done) {
        if (this.animateIn) {
          this.animateIn().then(done);
        } else {
          console.warn('missing animateIn on element with animateInOut transition');
          done();
        }
      },
      leave (el, done) {
        if (this.animateOut) {
          this.animateOut().then(done);
        } else {
          console.warn('missing animateOut on element with animateInOut transition');
          done();
        }
      }
    }
  }
});
