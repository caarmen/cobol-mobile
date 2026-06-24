package ca.rmen.coboldemo

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform