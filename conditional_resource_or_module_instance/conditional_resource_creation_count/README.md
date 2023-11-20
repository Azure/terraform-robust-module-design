# Conditional resource creation using count

This is the preferred way to create resources conditionally.
You can use the `one()` function to retrieve the zero index value for outputs, etc.

You would use a boolean value to control the count.
This can either be directly from an input variable, or by using a test expression.
We recommend that you test for null or not null.
