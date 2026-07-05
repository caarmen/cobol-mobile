package com.example.coboldemo

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ca.rmen.gnucobol.GnuCOBOL
import com.example.coboldemo.ui.theme.CobolDemoTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GnuCOBOL.initialize()
        val answerToLife = AnswerToLife(this)

        enableEdgeToEdge()
        setContent {
            CobolDemoTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    var greetingText by remember { mutableStateOf("Click the button to find out...") }
                    Column(modifier = Modifier
                        .padding(innerPadding)
                        .padding(16.dp)
                    ) {
                        Greeting(name = greetingText)
                        Spacer(modifier = Modifier.height(16.dp))
                        Button(onClick = {
                            greetingText = "${answerToLife.getAnswerToLife()}"
                        }) {
                            Text("Ask COBOL")
                        }
                    }
                }
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

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    CobolDemoTheme {
        Greeting("Android")
    }
}