package ca.rmen.gnucobol.kmp
import kotlinx.cinterop.ExperimentalForeignApi
import ca.rmen.gnucobol.cob_init


@OptIn(ExperimentalForeignApi::class)
actual fun initializeImpl() {
    // Call directly to the C api provided by the nativeInterop.
    // Calling the swift api would be complicated (would require exposing the Swift api through an Objective-C layer).
    cob_init(0, null)
}
