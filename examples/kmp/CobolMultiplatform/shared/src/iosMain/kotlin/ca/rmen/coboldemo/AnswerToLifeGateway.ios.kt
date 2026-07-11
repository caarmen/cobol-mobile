package ca.rmen.coboldemo

import answer.answerToLife
import kotlinx.cinterop.ExperimentalForeignApi
import platform.Foundation.NSFileManager
import platform.Foundation.temporaryDirectory

/*
 * Implementation of the AnswerToLifeGateway interface for iOS, calling into COBOL via c-interop.
 */
class IOSAnswerToLifeGateway : AnswerToLifeGateway {
    @OptIn(ExperimentalForeignApi::class)
    override fun getAnswerToLife(filePath: String): Int {
        return answerToLife(filePath)
    }

    @OptIn(ExperimentalForeignApi::class)
    override fun getTempFilePath(): String {
        val tempDir = NSFileManager.defaultManager.temporaryDirectory
        val fileUrl = tempDir.URLByAppendingPathComponent("test.txt")
        return fileUrl!!.path!!
    }
}