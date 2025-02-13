## Terraform (AWS):

Create two S3 buckets in each of the three environments (test, staging, production),ensure that:

<ol>
<li>some S3 buckets can have versioning enabled;</li>
<li>some S3 buckets can have object lock enabled with diﬀerent configuration per bucket (mode and retention)</li>
<li>each S3 bucket has tags that show cost centre and a product name it belongs to;</li>
<li>terraform modules are not used (just a "flat" terraform project); </li>
<li>there are might be many more S3 buckets in each environment with diﬀerent versioning and object lock configurations; </li>
</ol>

There are diﬀerent ways to structure and run the project. To simplify the task and focus on showing your terraform code skills, have one ".tfstate" file, and three variables (one per environment) in a single ".tfvars" file which will describe all your S3 buckets in each particular  environment.

Feel free to replace S3 buckets with any other AWS resource of your choice. We expect you to demonstrate your ability to use nested data structures, therefore make sure you have a root level resource and a number of nested resources (and no dynamic blocks).