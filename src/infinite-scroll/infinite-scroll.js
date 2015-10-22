import _ from 'lodash';

Vue.component('some-item', {
  props: {
    data: {
      type: Object,
      required: true
    },
    inViewport: {
      type: Boolean,
      required: true
    }
  },
  template: `
    <div :class="{'in-viewport': inViewport}">
      {{data | json}}
    </div>
  `,
  methods: {
    animateIn () {}
  }
});

export default Vue.extend({
  template: `
  <br><br>
  <br><br>
    <list
      :items="items"
      axis='y'
      item-component-name="some-item"
      style="
        max-height: 200px;
        overflow: auto;
        background-color: rebeccapurple;
      "
    >
    </list>
  `,
  data () {
    return {
      items: _.range(1000).map(() => {
        return {title: _.sample(['test', 'foo', 'bar', 'blah'])};
      })
    };
  },
  components: [
    require('sample-components/infinite-scroll/infinite-scroll.js')
  ]
});