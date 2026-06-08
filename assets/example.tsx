import { createClient, type Config } from "./api"

interface User {
  id: number
  name: string
  role: "admin" | "viewer"
  active: boolean
}

// Fetch users matching a search query
export async function searchUsers(config: Config, query: string): Promise<User[]> {
  const { baseUrl, timeout = 3000 } = config
  const endpoint = `${baseUrl}/api/users?q=${encodeURIComponent(query)}`

  const response = await fetch(endpoint, {
    headers: { "Content-Type": "application/json" },
    signal: AbortSignal.timeout(timeout),
  })

  if (!response.ok) {
    throw new Error(`Request failed: ${response.status}`)
  }

  const users: User[] = await response.json()

  return users.filter((user) => user.active)
}

export const client = createClient({
  port: 8080,
  debug: process.env.NODE_ENV !== "production",
  onReady: () => console.log("Connected on :8080"),
})
