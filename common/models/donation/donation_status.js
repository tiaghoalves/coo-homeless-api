'use strict';

export default (DonationStatus) =>  {
    DonationStatus.defaultData = [
        {
            "id_donation_status": 0,
            "type": "FAIL"
        },
        {
            "id_donation_status": 0,
            "type": "DOING"
        },
        {
            "id_donation_status": 0,
            "type": "DONE"
        }
    ]
};
