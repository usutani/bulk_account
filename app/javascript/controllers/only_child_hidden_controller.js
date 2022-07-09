import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="only-child-hidden"
export default class extends Controller {
  static targets = [ "childList", "hiddenElement" ]

  // 初期表示時、エラー表示時
  connect() {
    this.hideElements(this.isHidden(this.childListTarget.childElementCount))
    const observer = new MutationObserver(mutations => this.childListChanged(mutations))
    observer.observe(this.childListTarget, {childList: true, subtree: false})
  }

  isHidden(childElementCount) {
    return childElementCount <= 1
  }

  hideElements(hidden) {
    this.hiddenElementTargets.forEach(item => item.hidden = hidden)
  }

  // 子要素追加削除時
  childListChanged(mutations) {
    this.hideElements(this.isHidden(mutations[0].target.childElementCount))
  }
}
