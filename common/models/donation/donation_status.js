'use strict';

export default (DonationStatus) =>  {
    DonationStatus.defaultData = [
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
