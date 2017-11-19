'use strict';

export default (DonationItem) =>  {
    DonationItem.defaultData = [
        {
            "type": "FAIL"
        },
        {
            "type": "DOING"
        },
        {
            "type": "DONE"
        }
    ]
};
