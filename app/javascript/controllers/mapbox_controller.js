import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    duration: Number,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/enpina1/ckl2l10a71jb417tjhzkpxhoc"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    if (this.durationValue > 0) {
      this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl}))
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker()
        .setLngLat([ marker.longitude, marker.latitude ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.longitude, marker.latitude ]))
    this.map.fitBounds(bounds, { padding: 100, maxZoom: 15, duration: this.durationValue})
  }
}
