## 0.2.0

* Add `CornerShape` enum with `sharp`, `bevel`, `round`, `fillet` and `inset` variants.
* Add `Corner` model class with a `shape` and a `radius`.
* Add named constructors for each `CornerShape` variant.
* Add `Corner` field `corners` to `RegularPolygon`.
* Calculate `Path` in `RegularPolygon.getPath()` based on `corners` field.

## 0.1.0

* Add `RegularPolygon` model class with `sides`, `rotation`, `innerAngle` and `getPath()`.
* Add `triangle`, `square`, `pentagon`, `hexagon` and `octagon` named constructors.

## 0.0.1

* Initial version.
