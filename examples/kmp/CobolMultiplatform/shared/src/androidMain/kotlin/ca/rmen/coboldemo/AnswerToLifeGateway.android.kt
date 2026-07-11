package ca.rmen.coboldemo

import android.content.Context
import java.io.File

/*
 * Implementation of the AnswerToLifeGateway interface for Android, calling into COBOL via JNI.
 */
class AndroidAnswerToLifeGateway(private val context: Context) : AnswerToLifeGateway {
    companion object {
        init {
            System.loadLibrary("answer")
        }
    }
    external fun cobAnswerToLife(filePath: String): Int
    override fun getAnswerToLife(filePath: String): Int {
        return cobAnswerToLife(filePath)
    }

    override fun getTempFilePath(): String {
        return File.createTempFile("test.txt", null, context.cacheDir).absolutePath
    }

}