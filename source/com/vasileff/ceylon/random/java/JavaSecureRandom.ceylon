import ceylon.interop.java {
    javaByteArray,
    createJavaByteArray
}

import java.lang {
    ByteArray
}
import java.security {
    SecureRandom
}

"A cryptographically strong random number generator
 backed by `java.security.SecureRandom`."
by("John Vasileff")
shared final class JavaSecureRandom(
        "The seed, if provided, will be used to construct the
         `java.security.SecureRandom` delegate."
        {Byte*}|ByteArray? seed = null)
        extends JavaRandomAdapter<SecureRandom>(newSecureRandom(seed)) {

    "Delegates to `java.secure.SecureRandom.setSeed(byte[])`."
    shared void reseed(Integer|{Byte*}|ByteArray newSeed) {
        switch(newSeed)
        case (is Integer) { delegate.setSeed(newSeed); }
        case (is {Byte*}|ByteArray) {
            delegate.setSeed(toJavaSeed(newSeed));
        }
    }
}

ByteArray toJavaSeed({Byte*}|ByteArray bytes) {
    switch(bytes)
    case(is Integer|ByteArray) { return bytes; }
    case(is {Byte*}) {
        if (is Array<Byte> bytes) {
            return javaByteArray(bytes);
        } else {
            return createJavaByteArray(bytes);
        }
    }
}

SecureRandom newSecureRandom({Byte*}|ByteArray? seed) {
    if (exists seed) {
        return SecureRandom(toJavaSeed(seed));
    } else {
        return SecureRandom();
    }
}
