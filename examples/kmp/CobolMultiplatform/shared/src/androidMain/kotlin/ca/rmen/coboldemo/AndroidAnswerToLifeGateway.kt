/*
 * Implementation of the AnswerToLifeGateway interface for Android, calling into COBOL via JNI.
 */
package ca.rmen.coboldemo

class AndroidAnswerToLifeGateway : AnswerToLifeGateway {
    override fun getAnswerToLife(): Int {
        return 2 // TODO
    }
}