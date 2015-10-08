import sampleButton from 'sample-components/button/button.vue';

export default sampleButton.extend({
  props: {
    // override the default value for hasArrow
    hasArrow: {
      type: Boolean,
      required: false,
      default: true
    }
  },
  // add some default methods
  methods: {
    animateIn () {
      return animate.fromTo(this.$el, 0.5, {opacity: '0'}, {opacity: '1'});
    },
    animateOut () {
      return animate.to(this.$el, 0.5, {opacity: '0'});
    }
  }
});