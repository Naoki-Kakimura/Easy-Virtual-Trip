## plans

| Column | Type   | Option      |
|--------|--------|-------------|
| name   | string | null :false |

### Associations
has_one :trip_place
has_many :visit_points
has_one :weather


## trip_places

| Column       | Type       | Option      |
|--------------|------------|-------------|
| prefecture   | string     | null :false |
| municipality | string     | null :false |
| plan         | references | null :false |

### Associations
belongs_to :plan


## visit_points

| Column    | Type       | Option      |
|-----------|------------|-------------|
| latitude  | string     | null :false |
| longitude | string     | null :false |
| plan      | references | null :false |

### Associations
belongs_to :plan


## weathers

| Column      | Type       | Option      |
|-------------|------------|-------------|
| weather     | string     | null :false |
| temperature | string     | null :false |
| clothing    | integer    | null :false |
| plan        | references | null :false |

### Associations
belongs_to :plan