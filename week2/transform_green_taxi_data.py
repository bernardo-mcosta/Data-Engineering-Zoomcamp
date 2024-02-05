if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    data.rename(columns={'VendorID': 'Vendor_ID', 'RatecodeID': 'Ratecode_ID','PULocationID':'PU_Location_ID','DOLocationID':'DO_Location_ID'}, inplace=True)
    data.columns = (data.columns
                    .str.replace(' ','_')
                    .str.lower()
    )

    return data

@test
def test_output(output, *args):
    assert 'vendor_id' in output.columns, 'The column "vendor_id" does not exist in the DataFrame'
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with zero passangers'
    assert output['trip_distance'].isin([0]).sum() == 0, 'There are rides with zero trip distance'