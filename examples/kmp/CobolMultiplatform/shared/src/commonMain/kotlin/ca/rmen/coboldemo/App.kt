package ca.rmen.coboldemo

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.safeContentPadding
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ca.rmen.gnucobol.kmp.GnuCOBOL


@Composable
fun App(gateway: AnswerToLifeGateway= PreviewAnswerToLifeGateway()) {
    // In reality, this type of initialization call might be better
    // suited in app startup, which would be specific to Android and iOS.
    // We put it here just to demonstrate an example of calling COBOL code
    // from shared kmp code (commonMain).
    remember { GnuCOBOL.initialize() }
    PrivateApp(gateway)
}

@Composable
private fun PrivateApp(gateway: AnswerToLifeGateway) {
    MaterialTheme {
        var greetingText by remember { mutableStateOf("Click the button to find out...") }
        Column(
            modifier = Modifier
                .background(MaterialTheme.colorScheme.primaryContainer)
                .safeContentPadding()
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            Greeting(name = greetingText)
            Spacer(modifier = Modifier.height(16.dp))
            Button(onClick = {
                val tempDir = gateway.getTempFilePath()
                println("write to $tempDir")
                greetingText = "${gateway.getAnswerToLife(tempDir)}"
            }) {
                Text("Ask COBOL")
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "The answer to life, from COBOL, is: $name!",
        modifier = modifier
    )
}

@Preview
@Composable
fun AppPreview() {
    App(PreviewAnswerToLifeGateway())
}

private class PreviewAnswerToLifeGateway : AnswerToLifeGateway {
    override fun getAnswerToLife(filePath: String): Int = 123
    override fun getTempFilePath(): String = "temp"
}
