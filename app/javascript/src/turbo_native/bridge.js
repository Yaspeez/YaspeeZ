class Bridge {
  // Toggles navbar visibility in browser from Turbo Native
  static toggleNavBar() {
    const event = new CustomEvent("toggle-nav-bar")
    window.dispatchEvent(event)
  }

  // Sends a message to the native app, if active.
  static postMessage(name, data = {}) {
    // iOS
    window.webkit?.messageHandlers?.nativeApp?.postMessage({name, ...data})

    // Android
    window.nativeApp?.postMessage(JSON.stringify({name, ...data}))
  }
}

// Expose this on the window object so TurboNative can interact with it
window.TurboNativeBridge = Bridge
export default Bridge
