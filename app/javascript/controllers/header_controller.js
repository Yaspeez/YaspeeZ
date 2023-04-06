import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "searchBar", "searchInput"]
    connect() {
    }

    toggleSearchBar(){
        this.searchBarTarget.classList.toggle("hidden")
        if(!this.searchBarTarget.classList.contains("hidden")){
            this.searchInputTarget.focus()
        }
    }
}
