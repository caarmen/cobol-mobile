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


@Composable
fun App() {
    App(AnswerToLifeGateway())
}

@Composable
private fun App(gateway: AnswerToLifeGateway) {
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
                greetingText = "${gateway.getAnswerToLife()}"
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
    App(object : AnswerToLifeGateway {
        override fun getAnswerToLife(): Int = 123
    })
}
