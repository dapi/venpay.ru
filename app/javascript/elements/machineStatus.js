class MachineStatus extends HTMLElement {
  connectedCallback() {
    this.refresh()
  }

  handleRefreshClick = ({target}) => {
    this.refresh()
  }

  refresh = () => {
    this.innerHTML='<dapi-spinner></dapi-spinner>'
    const onLoad = (response) => {
      this
        .querySelector('[data-refresh]')
        .addEventListener('click', this.handleRefreshClick)
    }
    $(this).load(this.dataset.url, onLoad)
  }
}

customElements.define('dapi-machine-status', MachineStatus, {extends: 'div'});
