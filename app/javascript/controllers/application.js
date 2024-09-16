import { Application } from "@hotwired/stimulus"

const application = Application.start()

const context = require.context(".", true, /\.js$/)
context.keys().forEach(key => {
  if (key === './application.js') return // Skip itself
  const controller = context(key)
  const controllerName = key.replace(/^\.\/|\.js$/g, "")
  application.register(controllerName, controller.default)
})


// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
