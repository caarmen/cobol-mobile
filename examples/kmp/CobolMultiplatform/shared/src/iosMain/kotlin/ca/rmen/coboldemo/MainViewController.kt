package ca.rmen.coboldemo

import androidx.compose.ui.window.ComposeUIViewController
import ca.rmen.gnucobol.cob_init
import kotlinx.cinterop.ExperimentalForeignApi
import platform.UIKit.UIViewController

fun MainViewController(): UIViewController {
    @OptIn(ExperimentalForeignApi::class)
    cob_init(0, null)
    return ComposeUIViewController {
        App()
    }
}