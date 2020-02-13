import Rails from "@rails/ujs"

class MachineStatus extends HTMLElement {
  connectedCallback() {
    this.refresh()
  }

  handleRefreshClick = ({target}) => {
    Rails.disableElement(target);
    this.refresh()
  }

  refresh = () => {
    const onLoad = (response) => {
      this
      .querySelector('[data-refresh]')
      .addEventListener('click', this.handleRefreshClick)
    }
    $(this).load(this.dataset.url, onLoad)
  }
}

customElements.define('dapi-machine-status', MachineStatus, {extends: 'div'});
