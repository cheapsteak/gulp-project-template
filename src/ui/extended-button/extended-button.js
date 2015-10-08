import sampleButton from 'sample-components/button/button.vue';

export default sampleButton.extend({
  methods: {
    animateIn () {
      return animate.fromTo(this.$el, 0.5, {opacity: '0'}, {opacity: '1'});
    },
    animateOut () {
      return animate.to(this.$el, 0.5, {opacity: '0'});
    }
  }
});