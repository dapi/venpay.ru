
class MachineStatus extends HTMLElement {
  connectedCallback() {
    const onLoad = (e) => {
      console.log('onLoad')
    }
    $(this).load(this.dataset.url, onLoad)
  }
}

customElements.define('dapi-machine-status', MachineStatus, {extends: 'div'});
