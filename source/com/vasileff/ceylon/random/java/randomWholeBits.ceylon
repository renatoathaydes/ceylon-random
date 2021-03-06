import ceylon.math.whole {
    zero,
    Whole
}
import com.vasileff.ceylon.random.api {
    Random,
    randomLimits,
    LCGRandom
}

// positive Integer's only
Integer maxBits = smallest(randomLimits.maxBits, 62);

"Generate a [[ceylon.math.whole::Whole]] number holding `bits` pseudorandom bits.
 This method returns [[ceylon.math.whole::zero]] if `bits <= 0`."
shared Whole randomWholeBits(
        "The number of bits."
        variable Integer bits,
        "The entropy source."
        Random random = LCGRandom()) {
    variable Whole result = zero;
    while (bits > 0) {
        value x = smallest(bits, maxBits);
        // TODO: use Whole.leftLogicalShift when available
        result = result.timesInteger(2^x);
        result = result.plusInteger(random.nextBits(x));
        bits -= x;
    }
    return result;
}
