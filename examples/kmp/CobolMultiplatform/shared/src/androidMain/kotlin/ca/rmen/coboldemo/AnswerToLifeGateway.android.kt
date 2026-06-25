package ca.rmen.coboldemo

/*
 * Implementation of the AnswerToLifeGateway interface for Android, calling into COBOL via JNI.
 */
class AndroidAnswerToLifeGateway : AnswerToLifeGateway {
    companion object {
        init {
            System.loadLibrary("answer")
        }
    }
    external fun cobAnswerToLife(): Int
    override fun getAnswerToLife(): Int {
        return cobAnswerToLife()
    }

}

actual fun AnswerToLifeGateway(): AnswerToLifeGateway = AndroidAnswerToLifeGateway()
