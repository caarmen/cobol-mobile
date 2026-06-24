/*
 * Implementation of the AnswerToLifeGateway interface for iOS, calling into COBOL via c-interop.
 */
package ca.rmen.coboldemo

import answer.answerToLife
import kotlinx.cinterop.ExperimentalForeignApi

class IOSAnswerToLifeGateway : AnswerToLifeGateway {
    @OptIn(ExperimentalForeignApi::class)
    override fun getAnswerToLife(): Int {
        return answerToLife()
    }
}