package ca.rmen.gnucobol.kmp

object GnuCOBOL {
    fun initialize() {
        initializeImpl()
    }
}

expect fun initializeImpl()
