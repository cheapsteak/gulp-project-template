import hljs from 'highlight.js';
import _ from 'lodash';

const html = input => hljs.highlight('html', input).value;
const js = input => hljs.highlight('js', input).value;

const baseButton = `
<sample-button
  action="{{onClick}}"
  text="ACTION"
  >
</sample-button>
`;

const buttonWithArrow = `
<sample-button
  has-arrow="true"
  action="{{onClick}}"
  text="ACTION"
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

<extended-button
  v-show="showButton"
  v-transition="animateInOut"
  text="Always Arrow"
  >
</extended-button>
`

const topMenu = `
<top-menu
  sections="{{ topMenuSections }}"
  selected="{{ topMenuSections[0] }}">
</top-menu>
`;

let template = `
<table class="all-the-things">
  <tr>
    <td class="source">
      <pre v-pre>${html(baseButton)}</pre>
    </td>
    <td>
      ${baseButton}
    </td>
  </tr>
  <tr>
    <td class="source">
      <pre v-pre>${html(buttonWithArrow)}</pre>
    </td>
    <td>
      ${buttonWithArrow}
    </td>
  </tr>
  <tr>
    <td class="source">
      <pre v-pre>${html(buttonWithIcon)}</pre>
    </td>
    <td>
      ${buttonWithIcon}
    </td>
  </tr>
  <tr>
    <td class="source">
      <pre v-pre>${html(buttonWithDynamicText)}</pre>
    </td>
    <td>
      ${buttonWithDynamicText}
    </td>
  </tr>
  <tr>
    <td class="source">
      <pre v-pre>${html(extendedButton)}</pre>
    </td>
    <td>
      ${extendedButton}
    </td>
  </tr>
  <tr>
    <td class="source">
      <pre v-pre>${html(topMenu)}</pre>
    </td>
    <td>
      ${topMenu}
    </td>
  </tr>
</table>
`;

export default template;
