# frozen_string_literal: true
ds1 = Dataset.first
ds2 = Dataset.last

# join performance
Benchmark.ips(14) do |b|
  b.time = 10
  b.warmup = 2

  b.report('join') do
    Dataset.join_dataset(ds1, ds2, join_attribute: 'month',
                                   attribute: 'price',
                                   compare_attribute: 'index')
           .to_a
  end

  b.report('join on did') do
    DatasetRow.joins('INNER JOIN dataset_rows AS friends ON dataset_rows.dataset_id = friends.dataset_id')
              .where('dataset_rows.dataset_id = ?', ds1.id)
              .where('friends.dataset_id = ?', ds1.id)
              .to_a
  end

  b.compare!
end

# join vs eager load
Benchmark.ips(14) do |b|
  b.time = 10
  b.warmup = 2

  b.report('join') do
    Dataset.join_dataset(ds1, ds2, join_attribute: 'month',
                                   attribute: 'price',
                                   compare_attribute: 'index')
           .to_a
  end

  b.report('load & merge') do
    ds = Hash.new { |hash, key| hash[key] = [] }
    ds1.dataset_rows.each do |row|
      ds[row.dataset_attributes['month']][0] = row.dataset_attributes['price']
    end
    ds2.dataset_rows.each do |row|
      ds[row.dataset_attributes['month']][1] = row.dataset_attributes['index']
    end
    ds.to_a
  end

  b.compare!
end
