package ca.rmen.coboldemo

interface AnswerToLifeGateway {
    fun getAnswerToLife(filePath: String): Int
    fun getTempFilePath(): String
}