package ca.rmen.coboldemo

import answer.answerToLife
import kotlinx.cinterop.ExperimentalForeignApi

/*
 * Implementation of the AnswerToLifeGateway interface for iOS, calling into COBOL via c-interop.
 */
class IOSAnswerToLifeGateway : AnswerToLifeGateway {
    @OptIn(ExperimentalForeignApi::class)
    override fun getAnswerToLife(): Int {
        return answerToLife()
    }
}
actual fun AnswerToLifeGateway(): AnswerToLifeGateway = IOSAnswerToLifeGateway()