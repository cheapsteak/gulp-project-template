import hljs from 'highlight.js';
import _ from 'lodash';

const html = input => hljs.highlight('html', input).value;
const js = input => hljs.highlight('js', input).value;

const baseButton = `
<sample-button
  action="{{onClick}}"
  text="BUTTON"
  >
</sample-button>
`;

const importJs = `
components: {
  'sample-button': require('sample-components/button/button.vue'),
}
`;

const buttonWithArrow = `
<sample-button
  has-arrow="true"
  action="{{onClick}}"
  text="BUTTON"
  >
</sample-button>
`;

const buttonWithIcon = `
<sample-button
  icon-partial="icon-gps_fixed"
  text="Has an Icon"
  >
</sample-button>
`;

const buttonWithDynamicText = `
<sample-button
  action="{{incrementTextIndex}}"
  text="{{texts[textIndex % texts.length]}}"
  >
</sample-button>
<br><br>

<sample-button
  icon-partial="icon-flag"
  action="{{incrementTextIndex}}"
  text="{{texts[textIndex % texts.length]}}"
  >
</sample-button>
`;

const extendedButton = `
<button v-on="click: showButton = !showButton">
  toggle
</button>
<br><br>

<extended-button
  v-show="showButton"
  v-transition="animateInOut"
  text="Animate In/Out"
  >
</extended-button>
`

const extendedButtonJs = `
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
`;

const topMenu = `
<top-menu
  sections="{{ topMenuSections }}"
  selected="{{@ selectedSection }}">
</top-menu>

selected: {{selectedSection | json}}
`;

const template = `
<ul class="all-the-things">
  <li>
    ${baseButton}
  </li>
  <li>
    <pre v-pre>
    ${js(importJs)}
    ${html(baseButton)}
    </pre>
  </li>
  <li>
    <pre v-pre>${html(buttonWithArrow)}</pre>
    ${buttonWithArrow}
  </li>
  <li>
    <pre v-pre>${html(buttonWithIcon)}</pre>
    ${buttonWithIcon}
  </li>
  <li>
    <pre v-pre>${html(buttonWithDynamicText)}</pre>
    ${buttonWithDynamicText}
  </li>
  <li>
    <pre v-pre>${js(extendedButtonJs)}
    ${html(extendedButton)}</pre>
    ${extendedButton}
  </li>
  <li>
    <pre v-pre>${html(topMenu)}</pre>
    ${topMenu}
  </li>
</ul>
`;

export default template;
