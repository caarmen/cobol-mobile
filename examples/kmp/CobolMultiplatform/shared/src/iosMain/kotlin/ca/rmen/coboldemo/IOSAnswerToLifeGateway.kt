/*
 * Implementation of the AnswerToLifeGateway interface for iOS, calling into COBOL via c-interop.
 */
package ca.rmen.coboldemo

class IOSAnswerToLifeGateway : AnswerToLifeGateway {
    override fun getAnswerToLife(): Int {
        return 33 // TODO
    }
}