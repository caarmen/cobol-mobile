package com.example.coboldemo

import android.content.Context

// In companion object:

class AnswerToLife(private val context: Context) {
    companion object {
        init {
            System.loadLibrary("answer")
        }
    }

    external fun cobAnswerToLife(context: Context): Int

    fun getAnswerToLife(): Int {
        return cobAnswerToLife(context)
    }
}