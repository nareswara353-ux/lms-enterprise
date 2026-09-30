import { subscribeToNotifications } from "./notifications_channel"

document.addEventListener("turbo:load", () => {
  const badge = document.getElementById("notification-badge")
  if (!badge) return

  subscribeToNotifications((data) => {
    if (data.unread_count > 0) {
      badge.textContent = data.unread_count
    } else {
      badge.textContent = ""
    }
  })
})
