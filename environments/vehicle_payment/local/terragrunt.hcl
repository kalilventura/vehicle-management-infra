skip = false

include "root" {
    path = find_in_parent_folders("root.hcl")
}

inputs = {
    namespace = "vehicle-payment"
}
