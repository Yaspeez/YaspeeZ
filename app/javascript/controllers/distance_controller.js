import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rangeField", "showDistance"]

  changeRange(){
    this.showDistanceTarget.innerHTML = this.rangeFieldTarget.value + "km"
  }
}
