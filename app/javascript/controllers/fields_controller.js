import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"];

  add(e) {
    e.preventDefault();
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    this.containerTarget.insertAdjacentHTML('beforeend', content);
  }

  remove(e) {
    e.preventDefault();
    let item = e.target.closest('.nested-fields');
    if (item.dataset.newRecord === "true") {
      item.remove();
    } else {
      item.querySelector("input[name*='_destroy']").value = 1;
      item.style.display = "none";
    }
  }
}
